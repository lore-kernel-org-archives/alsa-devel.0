From: Stephen Hassard <steve@hassard.net>
Subject: Re: NV Soundstorm support? / Recording broke!
Date: Mon, 23 Jun 2003 07:18:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030623141821.GA19973@www.angiotech.com>
References: <20030623093405.22415.qmail@web9204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030623093405.22415.qmail@web9204.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel MacDonald <danboid@yahoo.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 23, 2003 at 02:34:05AM -0700, Daniel MacDonald wrote:
> My biggest question is- what is going on with Linux
> support for NVIDIA's NFORCE 2/ Soundstorm chipset?
> Have NVIDIA been contributing code or patches to ALSA
> or has the ALSA driver been created independently?
> More importantly, how long before we see PROPER
> support for the soundstorm under ALSA, instead of just
> a hacked intel8x0 driver? I want multiple dsp channels
> and 24-bit audio I/O under Linux please NVIDIA!

I'm almost positive that the Soundstorm is only a 16bit/48khz part. I'm also pretty sure that nvidia never advertised the soundstorm as such.

The soundstorm is generally attached to a Realtek ALC-650 for A/D-D/A functions. From the Realtek specs (http://www.realtek.com.tw/products/products1-2.aspx?modelid=30) it has a 20bit DAC but only >90dB S/N.

Looking at the nvidia specs (http://www.nvidia.com/docs/lo/2027/SUPP/APU_TechBrief_71502.pdf), it looks like one might be able to do 24bit, but it looks like you'll only get 48khz. Still, because they don't really mention it, I doubt you'll get anything more than 16/48 ..

later,
Steve


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
