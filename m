From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 - arecord, aoss
Date: Fri, 01 Apr 2005 20:16:45 +0800
Message-ID: <424D3BAD.3020409@netvigator.com>
References: <424988D4.2070805@netvigator.com> <1112170290.3207.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1112170290.3207.15.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Manuel Jander wrote:
>Raymond wrote:
> 
>>2) Do we need to define snd_vortex_capture_hw_adb to prevent multiple
>>programs perform recording while allowing multiple playback for ALSA and
>>OSS emulation ?
> 
> 
> Again, if it really does not bother anyone, why bother changing it ?
> Adding uneeded constraints, would limit the users creativity. I used
> this features once to setup a multitap delayorama, just using multiple
> XMMS, arecord and aplay. That was really cool ;)
> 

Is it possible to perform digital mix recording ?

	           Kcontrol (control volume of playbacks)
                          |
(Playback) -> SRC -+     v
                    +-> Mixer -> EQ -> Mixer -> Codec
(Playback) -> SRC -+                    |
                                         |
(Capture)  <- SRC <---------------------+
















-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
