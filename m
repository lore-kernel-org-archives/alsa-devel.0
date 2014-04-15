From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: split i2c from codec driver
Date: Tue, 15 Apr 2014 23:25:41 +0000
Message-ID: <C1EB06C9-0C0D-4443-9715-61F10C95FA8A@cirrus.com>
References: <1397594973-6947-1-git-send-email-brian.austin@cirrus.com>,
 <20140415225829.GM12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0082.outbound.protection.outlook.com [157.56.110.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E373260815
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 01:25:47 +0200 (CEST)
In-Reply-To: <20140415225829.GM12304@sirena.org.uk>
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



> On Apr 15, 2014, at 17:58, "Mark Brown" <broonie@kernel.org> wrote:
> 
>> On Tue, Apr 15, 2014 at 03:49:33PM -0500, Brian Austin wrote:
>> This patch removes the i2c bus code from the codec driver and creates seperate i2c driver.
> 
> Applied, thanks but there was some fuzz applying - please check it came
> out OK and that you were submitting against current code.

Thanks, it was based off of topic/cs42l51. I'll check it now
