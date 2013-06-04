From: "Keyon.Jey" <yang.jie@linux.intel.com>
Subject: Re: cplay error "Can't find sync world"
Date: Tue, 04 Jun 2013 08:12:45 +0800
Message-ID: <51AD30FD.9080406@linux.intel.com>
References: <51AC55B4.5080105@linux.intel.com>
 <20130603162004.GC31108@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 648732650AE
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 02:11:23 +0200 (CEST)
In-Reply-To: <20130603162004.GC31108@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/04/2013 12:20 AM, Charles Keepax wrote:
> On Mon, Jun 03, 2013 at 04:37:08PM +0800, Keyon.Jey wrote:
>> when I try use clpay -c 1 -d 2 test.mp3 to use tinycompress hwdec on my
>> phone, "Can't find sync world" always occurred, no matter what mp3 music
>> I try to play.
> I believe the issue here is cplay does not currently handle MP3s
> with meta data, such as track naming etc. You will need to strip
> anything like this from the start of the MP3 file before playing.
>
> Charles
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
it helps! thanks a lot, Charles!

Keyon
