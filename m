From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: status of usb audio driver
Date: Thu, 13 Jun 2002 01:48:33 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D077B61.7030902@boosthardware.com>
References: <s5h7klfdlrn.wl@alsa2.suse.de>	<3D06D91D.1080104@boosthardware.com>	<s5hhek81vgl.wl@alsa2.suse.de>	<3D07564B.4050908@boosthardware.com> <s5hbsag1t5r.wl@alsa2.suse.de> <3D0760FC.5060906@boosthardware.com> <3D0772F1.6090009@boosthardware.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Patrick Shirkey wrote:
> 
>>
>> i have been testing the sound and I am getting playback although at 
>> this point I can get sound out of hw:2,0 and hw:2,2 they are both the 
>> left channels. The sound is scratchy but it is there :)
>>
> 
> The sound is actually coming through output 2 and 4 on the sound card 
> even though I'm using hw:2,0 or hw:2,2.
> 

When I use the first two pcm devices the sound is sent through output 2 
on the card and when I use the third the sound is sent through output 4.

I have also tested capture and the card is not working with that yet.

It will attempt to record for a few seconds but will not write to a file 
or produce any noise either with direct monitoring enabled or not. Also 
  recording locks the mouse until either it has finished or is ctrl+c'd.





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
