From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: davinci-i2c,pcm updates
Date: Mon, 06 Jul 2009 15:51:25 -0700
Message-ID: <87k52ljuhe.fsf@deeprootsystems.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090705114122.GA5334@sirena.org.uk>
	<4A526CED.7050606@boundarydevices.com>
	<20090706214149.GC25548@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 253772455D
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:51:28 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1630463pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 15:51:28 -0700 (PDT)
In-Reply-To: <20090706214149.GC25548@sirena.org.uk> (Mark Brown's message of
	"Mon\, 6 Jul 2009 22\:41\:49 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Jul 06, 2009 at 02:30:21PM -0700, Troy Kisky wrote:
>
>> ARM: DaVinci: Interface changes visible to EDMA clients
>
>> But the last patch in series needs rebased on to this. Unfortunately,
>> this patch is not yet in your for-2.6.32 branch. So, unless this patch
>> is going to merge first, I show remove the need for this patch???
>
> Unless you can make your changes such that the above patch will merge in
> cleanly there's no point - we'll need to deal with the cross tree merge
> issues somehow.  That'll require coordination with Kevin; probably the
> best approach is to make a small branch which can be merged into both
> trees but that may be too involved.

For now, how about making anything that has arch/arm dependencies
apply to the 'davinci-next' branch of DaVinci git.

Kevin
