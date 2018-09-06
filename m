From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: sgtl5000: avoid division by zero if lo_vag is zero
Date: Thu, 6 Sep 2018 13:01:58 +0100
Message-ID: <43293b8e-5b9d-ff51-aa3f-eb1a7b9490aa@canonical.com>
References: <20180906104152.17977-1-colin.king@canonical.com>
 <20180906115814.a5woyhfc5sczxksa@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906115814.a5woyhfc5sczxksa@mwanda>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/09/18 12:58, Dan Carpenter wrote:
> On Thu, Sep 06, 2018 at 11:41:52AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> In the case where lo_vag <= SGTL5000_LINE_OUT_GND_BASE, lo_vag
>> is set to zero and later vol_quot is computed by dividing by
>> lo_vag causing a division by zero error.  Fix this by avoiding
>> a zero division and set vol_quot to zero in this specific case
>> so that the lowest setting for i is correctly set.
>>
> 
> This is a very clever patch.  How did you find the bug?

trawling through a lot of false positives from a recent cppcheck run

> 
> regards,
> dan carpenter
> 
