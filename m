From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: msnd: Optimize / harden DSP and MIDI
	loops
Date: Fri, 8 Sep 2017 21:10:03 +0200
Message-ID: <20170908191003.GA19292@kroah.com>
References: <20170908160626.24771-1-gtertych@cisco.com>
 <s5h377xqga2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 6677C266AE1
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 21:10:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h377xqga2.wl-tiwai@suse.de>
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
Cc: grygorii tertychnyi <gtertych@cisco.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, xe-linux-external@cisco.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 08, 2017 at 06:57:57PM +0200, Takashi Iwai wrote:
> On Fri, 08 Sep 2017 18:06:25 +0200,
> grygorii tertychnyi wrote:
> > 
> > Hi Greg,
> > 
> > Could you please apply it for 4.4-stable.
> > This fixes https://nvd.nist.gov/vuln/detail/CVE-2017-9985
> 
> This vulnerability is just non-issue.  You can't get it working
> practically; it requires a modified hardware of the decade old ISA
> sound card, and yet the system has to load / set up the module
> beforehand.  We should withdraw it from CVE, IMO.

Hah, good luck trying to get a CVE withdrawn, people seem to love the
foolish things...
