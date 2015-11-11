From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2] ASoC: damp: Reset dapm wcache after
 freeing damp widgets
Date: Wed, 11 Nov 2015 15:00:31 +0200
Message-ID: <56433BEF.4040906@ti.com>
References: <1447171962-15736-1-git-send-email-jsarha@ti.com>
 <20151110185308.GK12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E45DB260440
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 14:00:35 +0100 (CET)
In-Reply-To: <20151110185308.GK12392@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, balbi@ti.com
List-Id: alsa-devel@alsa-project.org

On 11/10/15 20:53, Mark Brown wrote:
> On Tue, Nov 10, 2015 at 06:12:42PM +0200, Jyri Sarha wrote:
>> If there is anything in damp->path_source_cache or
>> damp->path_sink_cache, it can not be valid after the widgets have been
>> freed. Without this patch a repeated remove and load of a machine
>> driver may cause NULL pointer reference in dapm_wcache_lookup() when a
>> freed widget, not belonging to any list, is haunting in the wcache.
>
> Please try to check the spelling in your subject lines!
>


Argh, these acronyms wont get corrected by blind spell checker run. I 
need to be more careful in the future, at least for the subject.

Sorry,
Jyri
