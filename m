From: Daniel Mack <zonque@gmail.com>
Subject: Re: Connecting two Codecs to the same CPU DAI
Date: Tue, 16 Jul 2013 18:33:39 +0200
Message-ID: <51E575E3.3040409@gmail.com>
References: <51E55925.5080208@gmail.com> <20130716162043.GS22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 35655264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 18:33:14 +0200 (CEST)
Received: by mail-ee0-f45.google.com with SMTP id c1so497016eek.18
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 09:33:13 -0700 (PDT)
In-Reply-To: <20130716162043.GS22506@sirena.org.uk>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 16.07.2013 18:20, Mark Brown wrote:
> On Tue, Jul 16, 2013 at 04:31:01PM +0200, Daniel Mack wrote:
> 
>> This is cumbersome of course, and I wonder how the core could be
>> augmented in order to handle such cases correctly. Ideally, it should
>> only expose one PCM interface and handle a list of Codecs in the back.
> 
>> Or am I unaware of an existing feature?
> 
> No, no feature here.  Off the top of my head I'd suggest soc-pcm plus a
> virtual DAI for the second link.

That would still require userspace to open and configure both
subdevices, right?

Do you think it's a good idea to teach DAI links support for more than
one codec? At a glance, it seems quite possible: the modes and rates
would be limited down to the intersection of those of each codec, and
the PCM callbacks would be relayed to all codecs in the list.


Thanks,
Daniel
