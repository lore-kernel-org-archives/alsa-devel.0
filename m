From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Mon, 31 Mar 2014 16:53:57 -0600
Message-ID: <5339F205.50403@wwwdotorg.org>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
 <20140331192349.GA3431@mithrandir> <5339C638.5030303@wwwdotorg.org>
 <20140331224520.GF2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D921A2651D5
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 00:54:01 +0200 (CEST)
In-Reply-To: <20140331224520.GF2269@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/31/2014 04:45 PM, Mark Brown wrote:
> On Mon, Mar 31, 2014 at 01:47:04PM -0600, Stephen Warren wrote:
> 
>> There seems to be a mix of ifdef'ing the table and using of_match_ptr()
>> vs. the other way around in ASoC. Mark, do you have a preference which
>> way to go?
> 
> of_match_ptr() is supposed to avoid the warnings that the ifdefs fixed
> more prettily - I suspect you'll find that the ones that don't use it
> either predate of_match_ptr() or copied something that did.

I believe you either have the ifdef and the of_match_ptr(), or you have
neither. The use of of_match_ptr() is required when you wrap the
struct/array in an ifdef, so that the struct/array is only referenced
when it's declared.

I guess from your response you want the struct/array wrapped in an
ifdef, and to use of_match_ptr() when referencing it. I'll go ahead with
that; no need to reply if that's what you meant.
