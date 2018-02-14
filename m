From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: wm9713: Use empty struct
 initializer
Date: Wed, 14 Feb 2018 17:15:28 +0000
Message-ID: <86924c5f-9f62-8d38-3a24-86e40b8cb843@opensource.cirrus.com>
References: <1518622745-12162-1-git-send-email-festevam@gmail.com>
 <1518622745-12162-2-git-send-email-festevam@gmail.com>
 <938aa54c-c599-9efc-e78f-4e72db08199e@opensource.cirrus.com>
 <CAOMZO5BS9oiDPT3oEK7ROhetJcHmfWL+XGZsY9ncMJsB9Qcbww@mail.gmail.com>
 <52f37612-1e70-33d7-f4c9-e1221e6667fd@opensource.cirrus.com>
 <CAOMZO5ASMYzPg4j2LfHqmVZ6VsE6094N2_rfkquoME2vj9Ab7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id C69B4267B6D
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 18:15:31 +0100 (CET)
In-Reply-To: <CAOMZO5ASMYzPg4j2LfHqmVZ6VsE6094N2_rfkquoME2vj9Ab7w@mail.gmail.com>
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

On 14/02/18 17:01, Fabio Estevam wrote:
> On Wed, Feb 14, 2018 at 2:56 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> 
>> I agree but your commit message didn't say that. It's irrelevant now
>> Mark has merged the patch, but for anyone looking at the commit message
>> later, the structure of your commit message implies that the problem
>> is that {0} doesn't work correctly (probably untrue and certainly not
> 
> Yes, and that is the message I want to give:
> 
> {0} does not work correctly if the first member of the struct is a
> pointer, as we should not explicitly write 0 to pointers.
> 

I gather that, so I'd have liked to your commit message to have said 
that. But what you actually said was

"{ 0 } only clears the first member of the structure."

which is a very different message.
