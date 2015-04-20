From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: [PATCH] ASoC: adau1701: add regulator consumer
	support
Date: Mon, 20 Apr 2015 10:49:44 +0200
Message-ID: <5534BDA8.3070608@gmail.com>
References: <1429008420-1566-1-git-send-email-pascal.huerst@gmail.com>
 <20150418132322.GV26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150418132322.GV26185@sirena.org.uk>
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
Cc: patch@alsa-project.org, tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 18.04.2015 15:23, Mark Brown wrote:
> On Tue, Apr 14, 2015 at 12:47:00PM +0200, pascal.huerst@gmail.com wrote:
>> From: Pascal Huerst <pascal.huerst@gmail.com>
>>
>> The adau1701 has two power domains, DVDD and AVDD.
>> Enable them both as long as the codec is in use.
>> ---
> 
> This looks fine but I can't apply it because you've not signed it off -
> I need a signoff for anything that's going to mainline.  Please see
> Documentation/SubmittingPatches.

Oh, seems like I missed a '-s', sorry! I'll resend.
