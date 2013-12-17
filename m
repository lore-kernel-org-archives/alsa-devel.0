From: Nenghua Cao <nhcao@marvell.com>
Subject: Re: [PATCH V2] ASOC:DAPM: update DPCM runtime when
	mixer/mux changes
Date: Tue, 17 Dec 2013 10:59:36 +0800
Message-ID: <52AFBE18.8060906@marvell.com>
References: <1386936829-9627-1-git-send-email-nhcao@marvell.com>
 <20131216201303.GQ3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CE157260857
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 03:53:10 +0100 (CET)
In-Reply-To: <20131216201303.GQ3185@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry Zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 12/17/2013 04:13 AM, Mark Brown wrote:
> On Fri, Dec 13, 2013 at 08:13:48PM +0800, Nenghua Cao wrote:
>> From: Nenghua Cao <nhcao@marvell.com>
>>
>> V2 -> V1:
>>
>>    Removes the flag and update DPCM always when mixer/mux changes, according
>> to Takashi's and Mark's suggestion.
> 
> Don't send cover letters for single patches, if there's anything that
> needs to be said put it after the --- in the patch mail.
> 
Got it. Thanks!
