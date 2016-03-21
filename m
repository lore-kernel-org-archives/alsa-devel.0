From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] [PATCH] amidi active sensing option
Date: Mon, 21 Mar 2016 08:41:17 +0100
Message-ID: <56EFA59D.3090002@ladisch.de>
References: <1458483024.19656.21.camel@leeuwenkuil.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id AA18F261AD0
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 08:41:25 +0100 (CET)
In-Reply-To: <1458483024.19656.21.camel@leeuwenkuil.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: m.tarenskeen@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Tarenskeen wrote:
> I searched on Google and found in the old alsa-devel archives the
> anouncement of this option to enable/disable detecting Active Sensing
> (0xfe) bytes with the amidi utility.
> But not only 0xfe (Active Sensing) should be blocked by default, also
> other Midi System Realtime messages. In other SysEx dump utilities
> that I know there is a simialr option called something like
> "rt-filter" or "realtime-filter".
> [...]
> I have attached my patch.

Thank you for this improvement.  However, the name of the option
("--active-sensing") is no longer correct, and the man page must be
updated, too.

Also, patches need a Signed-off-by line to indicate that the submitter
accepts the DCO; see <http://elinux.org/Developer_Certificate_Of_Origin>.


Regards,
Clemens
