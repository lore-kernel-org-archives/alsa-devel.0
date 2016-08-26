From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: locking looks odd
Date: Fri, 26 Aug 2016 21:02:12 +0200
Message-ID: <20160826190212.GR5165@var>
References: <20160816210322.GD4466@var.home>
 <0fec7ab2-f72f-a27a-e82b-58642836db88@perex.cz>
 <20160820121205.GK4252@var.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.aquilenet.fr (hera.aquilenet.fr [141.255.128.1])
 by alsa0.perex.cz (Postfix) with ESMTP id DDEAC267BF4
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 21:02:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160820121205.GK4252@var.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Samuel Thibault, on Sat 20 Aug 2016 14:12:05 +0200, wrote:
> I'd just like to check something: do we agree that libasound must be
> thread-safe by default (otherwise it breaks the application assumption
> that it's thread-safe)?  If so, then there are thread-safety bugs:

Ok, now with the discussion on the portaudio list starting at

https://lists.columbia.edu/pipermail/portaudio/2016-August/000599.html

it seems the issue was in portaudio, which was hit by the locking
behavior change.

Samuel
