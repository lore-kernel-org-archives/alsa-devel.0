From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Sat, 05 Apr 2003 23:48:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8F4F13.9070608@cucumelo.org>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch> <20030331114752.GA3187@wotan.suse.de> <20030404114623.GB9836@ulima.unil.ch> <3E8DC881.2070401@cucumelo.org> <20030404172526.GB12549@ulima.unil.ch> <3E8F248D.2000408@cucumelo.org> <20030405182915.GA31080@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: "Dr. Werner Fink" <werner@suse.de>, Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>??? No, the only reference I found about this option is regarding OSS
>(http://alsa.opensrc.org/index.php?page=cs46xx) and I never thought it
>was of any use for me...
>I have added
>options snd-cs46xx mmap_valid=1
>to my /etc/modules.conf and done an /etc/init.d/alsa restart without any
>change, so I try a /etc/init.d/alsa stop and checked that's there is no
>more alsa modules loaded at all and do a
>modprobe snd-cs46xx mmap_valid=1
>
>  
>
Adding it to modules.conf should be enough, that does not seems to be 
the problem anyway. So:

        if ((err = snd_pcm_hw_params_set_period_size(out, hwparams, 
MMAP_BURST, 0)) < 0) {
!!        esyslog("S/P-DIF: Period size not available: %s", 
snd_strerror(err));
        period_size = 0;
        goto err_out;
        }
        // function returns less than 0 on error or greater than 0
        if ((err = snd_pcm_hw_params_set_buffer_size_near(out, hwparams, 
burst_size*periods)) < 0) {
        esyslog("S/P-DIF: Buffer size not available: %s", 
snd_strerror(err));
        goto err_out;
        }
    } else {
        frag = 1;

        // function returns less than 0 on error or greater than 0
        if ((err = snd_pcm_hw_params_set_period_size(out, hwparams, 
burst_size, 0)) < 0) {
 !!       esyslog("S/P-DIF: Period size not available: %s", 
snd_strerror(err));
        period_size = 0;
        goto err_out;
        }

It seems to be the snd_pcm_hw_params_set_period_size(...) that fails, it 
seems to be two possible places where this function is called.
I guess there's a constraint in the cs46xx driver which does not allow 
the desired period settings, maybe someone with more knowledge about the 
alsa-lib  can help us figure out what ??

/Benny




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
