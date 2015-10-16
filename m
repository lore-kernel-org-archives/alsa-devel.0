From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH 0/7] ALSA: USB-audio: Support Zoom R16
 playback
Date: Fri, 16 Oct 2015 12:11:11 +1100
Message-ID: <20151016011111.GC20285@us.netrek.org>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B95C260523
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 03:11:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1444906657-16791-1-git-send-email-ricardw@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Ricard Wanderlof <ricard2005@butoba.net>, Ricard Wanderlof <ricardw@axis.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 15, 2015 at 12:57:30PM +0200, Ricard Wanderlof wrote:
> The Zoom R16 has a nonstandard playback format where each isochronous
> packet contains a length descriptor in the first four bytes. Curiously,
> capture data does not contain this and requires no quirk.  [...]

For the series,

Reviewed-by: James Cameron <quozl@laptop.org>

-- 
James Cameron
http://quozl.linux.org.au/
