From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: split i2c from codec driver
Date: Wed, 16 Apr 2014 01:28:43 +0000
Message-ID: <15FD0C57-F4F3-464C-A9A5-C18BD3A75762@cirrus.com>
References: <1397594973-6947-1-git-send-email-brian.austin@cirrus.com>
 <20140415225829.GM12304@sirena.org.uk>
 <C1EB06C9-0C0D-4443-9715-61F10C95FA8A@cirrus.com>,
 <20140415235817.GO12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0062.outbound.protection.outlook.com [157.56.110.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AEC6260859
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 03:28:47 +0200 (CEST)
In-Reply-To: <20140415235817.GO12304@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



> On Apr 15, 2014, at 18:58, "Mark Brown" <broonie@kernel.org> wrote:
> 
> On Tue, Apr 15, 2014 at 11:25:41PM +0000, Austin, Brian wrote:
>>> On Apr 15, 2014, at 17:58, "Mark Brown" <broonie@kernel.org> wrote:
> 
>>> Applied, thanks but there was some fuzz applying - please check it came
>>> out OK and that you were submitting against current code.
> 
>> Thanks, it was based off of topic/cs42l51. I'll check it now
> 
> Oh, that explains it.  Until I applied that patch there was no
> topic/cs42l51 - when Linus merges a branch I delete it and then start a
> new branch for any new work based off one of his -rcs (or another topic
> branch if there's a dependency).  Your copy of the branch will have been
> pre-merge window.  Since the merge window closed I'd deleted the old
> topic branch, the fuzz will have been due to some subsystem wide patches
> getting merged in.
Ah! That's good to know. I'm not that familiar with that yet, so I will keep better tabs on your branches and stick to for-next for compile tests.

Thanks Mark
