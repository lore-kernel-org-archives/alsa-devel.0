From: Tim Hollingsworth <tim@hollingsworth.com.au>
Subject: undefined reference to `snd_pcm_hw_params_sizeof'
Date: Wed, 17 Mar 2004 19:20:09 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0CC09933-7805-11D8-A740-000A95AB8A40@hollingsworth.com.au>
References: <1078416129.1865.868.camel@renegade>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078416129.1865.868.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I'm a newbie with alsa and rusty with c.  I am trying to get a basic 
pcm application going.  I have:

	#include <alsa/asoundlib.h>

but when I try to:

	snd_pcm_hw_params_alloca(&hwparams);

I get:

/tmp/ccJB6E1d.o(.text+0x18): In function `initSound':
: undefined reference to `snd_pcm_hw_params_sizeof'
/tmp/ccJB6E1d.o(.text+0x31): In function `initSound':
: undefined reference to `snd_pcm_hw_params_sizeof'
collect2: ld returned 1 exit status

any help appreciated
cheers
Tim

Full source so far:

     #include <alsa/asoundlib.h>

     /* Handle for the PCM device */
     snd_pcm_t *pcm_handle;

     /* Playback stream */
     snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK;

     /* This structure contains information about    */
     /* the hardware and can be used to specify the  */
     /* configuration to be used for the PCM stream. */
     snd_pcm_hw_params_t *hwparams;

     /* Name of the PCM device, like plughw:0,0          */
     /* The first number is the number of the soundcard, */
     /* the second number is the number of the device.   */
     char *pcm_name;


int initSound(int channels, int sampleRate, int framebytes)
{

     /* Init pcm_name. Of course, later you */
     /* will make this configurable ;-)     */
     pcm_name = strdup("plughw:0,0");


     /* Allocate the snd_pcm_hw_params_t structure on the stack. */
     snd_pcm_hw_params_alloca(&hwparams);
}

main(){}



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
