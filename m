From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: wm9713: Use empty struct
 initializer
Date: Wed, 14 Feb 2018 16:56:52 +0000
Message-ID: <52f37612-1e70-33d7-f4c9-e1221e6667fd@opensource.cirrus.com>
References: <1518622745-12162-1-git-send-email-festevam@gmail.com>
 <1518622745-12162-2-git-send-email-festevam@gmail.com>
 <938aa54c-c599-9efc-e78f-4e72db08199e@opensource.cirrus.com>
 <CAOMZO5BS9oiDPT3oEK7ROhetJcHmfWL+XGZsY9ncMJsB9Qcbww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BE449267B6D
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 17:56:55 +0100 (CET)
In-Reply-To: <CAOMZO5BS9oiDPT3oEK7ROhetJcHmfWL+XGZsY9ncMJsB9Qcbww@mail.gmail.com>
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
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

On 14/02/18 16:49, Fabio Estevam wrote:
> On Wed, Feb 14, 2018 at 2:41 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> 
>> This is the actual problem you are trying to fix? The comment about
>> { 0 } only clearing the first member is probably bogus, your actual
>> problem is that it should have been { NULL } ?
> 
> Changing to { NULL } fixes the sparse warning, but that would be a
> fragile fix because it relies on the order of the struct members.
> 
> If someday the struct changes in a way so that the first member is no
> longer a pointer, then we will have issues again.
> 
> Using {} is more error prone.
> 

I agree but your commit message didn't say that. It's irrelevant now
Mark has merged the patch, but for anyone looking at the commit message
later, the structure of your commit message implies that the problem
is that {0} doesn't work correctly (probably untrue and certainly not
the actual problem.) and your actual fix relies on precisely the
behaviour that the first line of your commit message implies is broken.

I just like commit messages to be accurate about what the problem was
and why. It's often said that an incorrect comment is worse than not
having the comment at all, and the same could be said for commit
messages,
