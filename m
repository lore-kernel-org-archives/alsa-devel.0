From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: proper use of snd_mixer_selem_set_capture_switch ?
Date: Fri, 5 Sep 2008 09:38:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0809050936130.9153@tm8103.perex-int.cz>
References: <20080905005707.GJ5930@arwen.poofy.goof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DFAEE2433E
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 09:38:36 +0200 (CEST)
In-Reply-To: <20080905005707.GJ5930@arwen.poofy.goof.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aaron J. Grier" <agrier@poofygoof.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Sep 2008, Aaron J. Grier wrote:

> does anyone have a good example or walkthrough how to change capture
> sources?  I'm having a heck of a time.
> 
> I feel I must be missing something obvious, like a flush operation, or
> something very simple.  who knew changing a mux could be such an
> involved procedure?  (=

snd_mixer_handle_events() is your friend, otherwise values are cached in 
alsa-lib. Or maybe, you reached a bug ;-) Let me know, if mentioned 
function does not fix your problem.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
