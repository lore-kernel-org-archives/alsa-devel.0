From: "Bouterse, Bob" <bob.bouterse@dm-holdings-na.com>
Subject: snd_ctl_elem_write fails -EPERM if snd_pcm is open
Date: Tue, 15 Apr 2008 13:33:33 -0400
Message-ID: <6601CF63C167F44A9A9E97E41EE4B16C685945@CLUSTEREX.corporate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p01c11o144.mxlogic.net (p01c11o144.mxlogic.net [208.65.144.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EE0124737
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 19:33:50 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am trying to sent IEC958 status bits on a VT1708A HAD-INTEL codec
while audio is being output.
snd_ctl_elem_write returns -EPERM from
linux-2.6.24.3/sound/core/control.c:769 .
 
Is there some way I can do this?
 
FYI using iecset will also give you an:
# iecset copywrite on
snd_ctl_elem_write: Operation not permitted
 
I am using alsa-lib-1.0.14a
 
$uname -a
Linux vision-vs 2.6.24.3 #1 SMP Fri Mar 28 09:35:45 EDT 2008 i686
unknown
 
$ gcc -v
Target: x86_64-linux-gnu
Configured with: ../src/configure -v
--enable-languages=c,c++,fortran,objc,obj-c++,treelang --prefix=/usr
--enable-shared --with-system-zlib --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --enable-nls
--with-gxx-include-dir=/usr/include/c++/4.2 --program-suffix=-4.2
--enable-clocale=gnu --enable-libstdcxx-debug --enable-mpfr
--enable-checking=release --build=x86_64-linux-gnu
--host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 4.2.3 20071123 (prerelease) (Debian 4.2.2-4)
 
If it helps, here is the code I am using to set the bits. I modeled this
after the iecset.c code. Everything opens fine, it is the final call to
"snd_ctl_elem_write(this->ctl_handle, cval))" that fails.
 
static int ao_alsa_set_spdif_status(ao_driver_t *this_gen,
snd_aes_iec958_t* iec958)
{
    alsa_driver_t        *this = (alsa_driver_t *) this_gen;
    config_values_t      *config = this->class->xine->config;
    char                 *pcm_device;
    snd_ctl_card_info_t  *hw_info;
    int                   err;
    snd_pcm_info_t       *pcm_info;
    int                   card;
    char                  card_name[20];
    snd_ctl_elem_list_t  *clist;
    snd_ctl_elem_id_t    *cid;
    snd_ctl_elem_value_t *cval;
    unsigned int          controls, cidx;
    const char *spdif_str = SND_CTL_NAME_IEC958("", PLAYBACK, DEFAULT);
    int                   opened_audio=0;
 
 
    llprintf(LOG_TRACE_ENTER, "Entered\n");
 
            if(!this->ctl_handle) {
                        if (!this->audio_fd) {
                                    pcm_device =
config->lookup_entry(config,
"audio.device.alsa_passthrough_device")->str_value;
                                    llprintf(LOG_MIXER,"Calling
local_snd_pcm_open(%s)\n", pcm_device);
 
err=local_snd_pcm_open(&this->audio_fd, pcm_device,
SND_PCM_STREAM_PLAYBACK, 1); /* NON-BLOCK mode */
                                    if ( err <0 )
                                    {
                                                xine_log
(this->class->xine, XINE_LOG_MSG,
 
_("local_snd_pcm_open() failed:%d:%s\n"), err, snd_strerror(err)); 
                                                return -1;
                                    }
                                    opened_audio = 1;
                        }
            
                        snd_pcm_info_alloca(&pcm_info);
                        snd_pcm_info(this->audio_fd, pcm_info);
            
                        card = snd_pcm_info_get_card(pcm_info);
                        llprintf(LOG_MIXER,"snd_pcm_info_get_card()
returned %d\n", card);
                        if(card < 0){
                                    sprintf(card_name, "default");
                        }
                        else{
                                    sprintf(card_name, "hw:CARD=%i",
card);
                        }
            
                        if (opened_audio && this->audio_fd) {
                                    snd_pcm_close(this->audio_fd);
                                    this->audio_fd = NULL;
                                    opened_audio = 0;
                        }
            
                        llprintf(LOG_MIXER,"Calling snd_ctl_open(%s)\n",
card_name);
                        if ( (err = snd_ctl_open (&this->ctl_handle,
card_name, 0)) < 0 )
                        {
                                    xprintf (this->class->xine,
XINE_VERBOSITY_DEBUG, "%s: snd_ctl_open(): %s\n", LOG_MODULE,
snd_strerror(err));
                                    return -1;
                        }
            }
 
            snd_ctl_card_info_alloca(&hw_info);
 
    if ( (err = snd_ctl_card_info (this->ctl_handle, hw_info)) < 0 )
    {
        xprintf (this->class->xine, XINE_VERBOSITY_DEBUG,
                 "%s: snd_ctl_card_info(): %s\n", LOG_MODULE,
snd_strerror(err));
                        snd_ctl_close(this->ctl_handle);
                        this->ctl_handle = 0;
        return -1;
    }
 
    /* set the spdif status bits */
    snd_ctl_elem_list_alloca(&clist);
    if ((err = snd_ctl_elem_list(this->ctl_handle, clist)) < 0) {
        xprintf (this->class->xine, XINE_VERBOSITY_DEBUG,
"snd_ctl_elem_list(): %s\n", snd_strerror(err));
                        snd_ctl_close(this->ctl_handle);
                        this->ctl_handle = 0;
        return -1;
    }
    if ((err = snd_ctl_elem_list_alloc_space(clist,
snd_ctl_elem_list_get_count(clist))) < 0) {
        xprintf (this->class->xine, XINE_VERBOSITY_DEBUG,
"snd_ctl_elem_list_alloc_space(): %s\n", snd_strerror(err));
                        snd_ctl_close(this->ctl_handle);
        return -1;
    }
    if ((err = snd_ctl_elem_list(this->ctl_handle, clist)) < 0) {
        xprintf (this->class->xine, XINE_VERBOSITY_DEBUG,
"snd_ctl_elem_list(): %s\n", snd_strerror(err));
                        snd_ctl_close(this->ctl_handle);
                        this->ctl_handle = 0;
        return -1;
    }
 
    controls = snd_ctl_elem_list_get_used(clist);
    for (cidx = 0; cidx < controls; cidx++) {
        if (!strcmp(snd_ctl_elem_list_get_name(clist, cidx), spdif_str))
            break;
    }
    if (cidx >= controls) {
        fprintf(stderr, "control \"%s\" not found\n", spdif_str);
                        snd_ctl_close(this->ctl_handle);
                        this->ctl_handle = 0;
        return -1;
    }
 
    snd_ctl_elem_id_alloca(&cid);
    snd_ctl_elem_list_get_id(clist, cidx, cid);
    snd_ctl_elem_value_alloca(&cval);
    snd_ctl_elem_value_set_id(cval, cid);
 
            llprintf(LOG_MIXER,"Writing
AES0=0x%02x,AES1=0x%02x,AES2=0x%02x,AES3=0x%02x\n",
           iec958->status[0], iec958->status[1], iec958->status[2],
iec958->status[3]);
 
    /* store the values */
    snd_ctl_elem_value_set_iec958(cval, iec958);
    if ((err = snd_ctl_elem_write(this->ctl_handle, cval)) < 0) {
        xprintf (this->class->xine, XINE_VERBOSITY_DEBUG,
"snd_ctl_elem_write(): %s\n", snd_strerror(err));
                        snd_ctl_close(this->ctl_handle);
                        this->ctl_handle = 0;
    }
 
    llprintf(LOG_MIXER,"snd_ctl_elem_write() returrned %d\n",err);
 
    /*-------------------------------------------------------*/
    /*snd_ctl_close (this->ctl_handle);*/
 
    return 0;
}
----------------------------------------------------
Bob Bouterse
Sr. Software Engineer
D&M Holdings Inc.
