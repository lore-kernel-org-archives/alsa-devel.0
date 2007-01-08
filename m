From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: Re: initialize dl handles where it needs to
Date: Mon, 08 Jan 2007 15:15:45 +0100
Message-ID: <45A25211.8050704@purplelabs.com>
References: <45A24929.50500@purplelabs.com> <s5h8xgdwqvr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xgdwqvr.wl%tiwai@suse.de>
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
> At Mon, 08 Jan 2007 14:37:45 +0100,
> Benoit Fouet wrote:
>   
>> Hi,
>>
>> this trivial patch initializes dl handle in timer.c and timer_query.c
>> where it needs to.
>>
>> Signed-off-by: Benoit Fouet <benoit.fouet@purplelabs.com>
>>     
>
> I think the code really won't access the uninitialized h, but
> initializing this variable is nice for code maintenance POV, anyway.
>   
reading it quickly, i found one case reaching this point:
around line 120 in timer.c:
err = snd_config_search_definition(timer_root, "timer_type", str,
&type_conf);
    if (err >= 0) {
        if (snd_config_get_type(type_conf) != SND_CONFIG_TYPE_COMPOUND) {
            SNDERR("Invalid type for TIMER type %s definition", str);
            goto _err;
        }

in which case we reach the _err label with err equal to zero:
if (! err) {
        err = open_func(timer, name, timer_root, timer_conf, mode);
        if (err < 0)
            snd_dlclose(h);

> Applied to ALSA tree now.  Thanks.
>
>
> Takashi
>
>   
Thanks

Ben


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
