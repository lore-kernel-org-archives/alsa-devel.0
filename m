From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 14/14] cplay: support
	auto-configuration	of fragment size and count
Date: Mon, 11 Feb 2013 10:10:36 +0000
Message-ID: <20130211101036.GA28335@opensource.wolfsonmicro.com>
References: <20130210002340.GN31139@opensource.wolfsonmicro.com>
 <20130211085311.GC3789@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27171260325
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 11:18:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130211085311.GC3789@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>looks like patches you have generated against is
>older one.

This is the git log of our development repository:

cplay: support auto-configuration of fragment size and count <Richard Fitzgerald>
compress: Prevent divide-by-zero faults in get_hpointer() <Richard Fitzgerald>
compress: Do not put newlines on error messages <Charles Keepax>
compress: Return error messages correctly from compress_open <Charles Keepax>
compress: Return error when failing to allocate compress struct <Charles Keepax>
compress: Extend limit on error messages <Charles Keepax>
Add makefile for building under standard linux <Richard Fitzgerald>
Add missing header includes <Richard Fitzgerald>
Block if unable to write all data in single write() <Richard Fitzgerald>
Allow client to pass "don't care" for fragment size/number <Richard Fitzgerald>
Handle case of pause() during compress_write() <Richard Fitzgerald>
Remove hardcoded limit on length of poll() wait <Richard Fitzgerald>
Fix incorrect error message on compress_resume() <Richard Fitzgerald>
Take local copy of compr_config structure <Richard Fitzgerald>
Change running from bitfield to plain int <Richard Fitzgerald>
Remove unused buffer_size member from struct compress <Richard Fitzgerald>
Change compress_write() to take buffer as const void * <Richard Fitzgerald>
Add function to get timestamp in samples <Richard Fitzgerald>
compress: add compress_resume <Namarta Kohli>
compress: write when we have a fragment to write <Vinod Koul>
compress: fix the timestamp calculation <Vinod Koul>
initial creation <Vinod Koul>
Initial test commit... <Jaroslav Kysela>
