From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: Re: initialize dl handles where it needs to
Date: Mon, 08 Jan 2007 15:50:58 +0100
Message-ID: <45A25A52.5010502@purplelabs.com>
References: <45A24929.50500@purplelabs.com>	<s5h8xgdwqvr.wl%tiwai@suse.de>	<45A25211.8050704@purplelabs.com>
	<s5h7ivxwps5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7ivxwps5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 08 Jan 2007 15:15:45 +0100,
> Benoit Fouet wrote:
>   
>> reading it quickly, i found one case reaching this point:
>> around line 120 in timer.c:
>> err = snd_config_search_definition(timer_root, "timer_type", str,
>> &type_conf);
>>     if (err >= 0) {
>>         if (snd_config_get_type(type_conf) != SND_CONFIG_TYPE_COMPOUND) {
>>             SNDERR("Invalid type for TIMER type %s definition", str);
>>             goto _err;
>>         }
>>     
>
> Ah, in that case, we should set err in a real error code such as
> -EINVAL.
>
>   
yes, could be a good idea...
in that case, my previous patch is useless, even if the warning will
surely still be there.

Ben


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
