From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb quattro not recording
Date: Thu, 05 Dec 2002 11:42:04 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEEBCFC.4060707@boosthardware.com>
References: <20021201105428.2afa833d.jean-marc.harang@laposte.net>	<Pine.HPX.4.33n.0212020920100.7780-100000@studcom.urz.uni-halle.de>	<s5hbs44bxyp.wl@alsa2.suse.de>	<3DEB23B8.6070507@mail.alamy.idv.tw> <s5h4r9wbsoy.wl@alsa2.suse.de> <3DEB879C.4070501@boosthardware.com> <3DEB975A.9060902@boosthardware.com> <3DED1A7F.40807@boosthardware.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Patrick Shirkey wrote:
> 
>> Much to my surprise the quattro has stopped being able to record with 
>> cvs from Nov 27 2002 and also a fresh checkout today.
>>
> 
> It's definitely broken as going back to the 18 November works. 
> 

After doing more testing it seems that the quattro requires that *both* 
pcms are initialised with the qinit util. Can someone tell me how to 
modify this so that hw:0,0 and hw:0,1 are both accessed please?

---------

/* program to prime an alsa device without sending data

Save as qinit.c and compile with:

         gcc -o qinit qinit.c -lasound -ldl -lm

*/


#include <alsa/asoundlib.h>

int main()
{
         snd_pcm_t *pcm;
         int err;
         snd_pcm_hw_params_t *hw;
         printf("Initialising quattro\n");
         err = snd_pcm_open(&pcm, "hw:0,0", SND_PCM_STREAM_PLAYBACK, 0);
         snd_pcm_hw_params_alloca(&hw);
         err = snd_pcm_hw_params_any(pcm, hw);
         err = snd_pcm_hw_params_set_access(pcm, hw, 
SND_PCM_ACCESS_RW_INTERLEAVED);
         err = snd_pcm_hw_params_set_format(pcm, hw, SND_PCM_FORMAT_S16_LE);
         err = snd_pcm_hw_params_set_rate(pcm, hw, 48000, 0);
         err = snd_pcm_hw_params_set_channels(pcm, hw, 2);
         err = snd_pcm_hw_params_set_period_size(pcm, hw, 512, 0);
         err = snd_pcm_hw_params_set_buffer_size(pcm, hw, 1024);
         err = snd_pcm_hw_params(pcm, hw);
         return err;
}

-----------
-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
