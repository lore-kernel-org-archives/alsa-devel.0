From: Bernhard Gerlach <gerlacbd@emt.iis.fhg.de>
Subject: Re: Q:  Error on compiling/linking
Date: Fri, 10 Oct 2003 09:25:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F865EE1.8080704@emt.iis.fhg.de>
References: <3F8587F0.1070902@emt.iis.fhg.de> <s5hy8vu7500.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8vu7500.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Unfortunatly I forget to mention that the functions listed in the 
documentation which is linked to on Takashi's page (section "Documents 
on Alsa") seem to work, eg. snd_card_get_name, snd_seq_open and so on. 
That is the old api, isn't it?


Takashi Iwai wrote:

>>When compiling/linking, I receive:
>>"undefined reference to `snd_seq_client_info_malloc'"
>>Same for snd_seq_client_info_get_name and for snd_seq_client_info_free.
>>
>>What's wrong? Is'nt my lib up to date? (I read that the sequencer api 
>>has been rewritten with get/set functions, but in which version?)
> 
> 
> how do you link libasound?

The compiler options are -Wl,-Bdynamic -lasound.
ldd says (when commenting out the not working function calls and 
compiling) that libasound.so.2 was linked.


Bernhard




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
