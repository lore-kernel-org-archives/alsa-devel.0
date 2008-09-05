From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: Re: proper use of snd_mixer_selem_set_capture_switch ?
Date: Fri, 5 Sep 2008 10:16:07 -0700
Message-ID: <20080905171607.GN5930@arwen.poofy.goof.com>
References: <20080905005707.GJ5930@arwen.poofy.goof.com>
	<Pine.LNX.4.61.0809050936130.9153@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.poofygoof.com (209-162-215-114.dq1sn.easystreet.com
	[209.162.215.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B71224687
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 19:16:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0809050936130.9153@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 05, 2008 at 09:38:36AM +0200, Jaroslav Kysela wrote:
> snd_mixer_handle_events() is your friend, otherwise values are cached
> in alsa-lib. Or maybe, you reached a bug ;-) Let me know, if mentioned
> function does not fix your problem.

that's exactly what I needed, and now everything is working as expected!
thanks!

-- 
  Aaron J. Grier | "Not your ordinary poofy goof." | agrier@poofygoof.com
