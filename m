From: Nenghua Cao <nhcao@marvell.com>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Fri, 13 Dec 2013 19:53:21 +0800
Message-ID: <52AAF531.8020200@marvell.com>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
 <20131212104347.GH11044@sirena.org.uk>
 <F766E4F80769BD478052FB6533FA745D4E76B8FA79@SC-VEXCH4.marvell.com>
 <20131212110718.GI11044@sirena.org.uk>	<52AAF09A.40302@marvell.com>
 <s5hy53phthr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id D839D261589
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:47:46 +0100 (CET)
In-Reply-To: <s5hy53phthr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Henry Zhao <xzhao10@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/2013 07:37 PM, Takashi Iwai wrote:
> At Fri, 13 Dec 2013 19:33:46 +0800,
> Nenghua Cao wrote:
>> > 
>> > Hi, Mark:
>> > 
>> > On 12/12/2013 07:07 PM, Mark Brown wrote:
>>> > > On Thu, Dec 12, 2013 at 02:56:08AM -0800, Nenghua Cao wrote:
>>> > > 
>>> > > Don't top post.  Please also fix your mailer to word wrap within
>>> > > paragaphs, it makes your mails much more legible.
>>> > > 
>> > It is my fault and Thanks for your kindly reminder. I just made my
>> > mailer work as community's request.
>>>>> > >> >    For common mix/mux which aren't related with DPCM, it doesn't need
>>>>> > >> >    to do DPCM update. And it still can use the old controls. But for
>>>>> > >> >    the mix/mux which impacts fe<->be link, they need to do this works.
>>>>> > >> >    For them, they call use the new set of controls. I think it can
>>>>> > >> >    make our code has better backward-compatibility.
>>> > > How does this improve backwards compatibility?
>> > My thought is that we distinguish different requirement through flag
>> > (you can find dpcm_checked in my patch).
> The question is rather what do you mean as "backward compatibility".
> 
> Usually backward compatibility is concerned when something new breaks
> the existing ones.  In your case, always updating DPCM would work,
> too, even without an extra flag; it's just suboptimal.
> 
Yes, you are right. I add this flag only for avoiding the traversing
dai_link in soc_dpcm_runtime_update(). So you think this work is
unnecessary. I will make another patch which will do DPCM runtime update
always. Is it Ok?
> 
> Takashi

Thanks
