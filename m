From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Sat, 06 Jul 2002 03:11:32 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D25E154.3000402@boosthardware.com>
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
To: Paul Davis <pbd@op.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>client alsa_pcm: inprocess client, execution_order=0.
>>ALSA: poll time out polled for 44800.813378
>>driver wait function failed, exiting
>>telling signal thread that the engine is done
>>jack main caught signal 1
> 
> 
> which means that the JACK alsa driver/client didn't return from poll
> on the ALSA streams within the given timeout: ie. one or both of them
> is not running.
> 

ie. I didn't have the card turned on :)

Just did it again and realised why.

> --p
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
