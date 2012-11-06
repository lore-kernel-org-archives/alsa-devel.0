From: Liam Girdwood <lrg@ti.com>
Subject: Re: commit: dpcm: Allow FE to be opened without valid
	BE routes
Date: Tue, 6 Nov 2012 17:32:58 +0000
Message-ID: <509949CA.5000103@ti.com>
References: <mailman.495.1352127790.820.alsa-devel@alsa-project.org>
 <1352221394.4968.38.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E64D2625D4
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 18:33:01 +0100 (CET)
In-Reply-To: <1352221394.4968.38.camel@anish-Inspiron-N5050>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <anish198519851985@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 06/11/12 17:03, anish kumar wrote:
> Commit 3ac3f5ca91afc03587b1d2d642f126efc5be37ca
> ASoC: dpcm: Allow FE to be opened without valid BE routes.
>
>          if (dpcm_path_get(fe, stream, &list) <= 0) {
> -               dev_warn(fe->dev, "asoc: %s no valid %s route\n",
> +               dev_dbg(fe->dev, "asoc: %s no valid %s route\n",
>                          fe->dai_link->name, stream ? "capture" :
> "playback");
> -                       mutex_unlock(&fe->card->mutex);
> -                       return -EINVAL;
>          }
>
>
> As I can see this commit has changed the log level from dev_warn to
> dev_dbg but this has caused a subtle problem.Right now we rely on this
> warning to find out issues related to "application not sending UCM
> commands causing mute issues".Sometimes we have seen that the device
> becomes mute due to application not sending UCM command properly and
> these issues are hard to reproduce(all we get is dump).So all we have is
> this log to find out if the FE(front-end) and BE(back-end) has at-lease
> matched or not and most of the time it doesn't and we find out that
> using this very log.
>
> With this gone it would be difficult to find out the problem.I don't see
> any harm in reverting it back to dev_warn as it will warn us that "still
> we have not received UCM command for turning on Back-end" and in case we
> receive it then this log hardly matters and just gives us information
> that "at that time it was not a valid route".
>
> If everyone agrees then I would be more than happy to send a patch.
>

I did the change since it is quite valid use case to open the FE PCM device 
without a configured route to a BE (as some Android devices do). This was 
filling up the log with lots of warning messages when in fact there was 
nothing wrong.

It sounds like from your description you are doing some debugging and 
dev_dbg() is intended for this.

Liam
