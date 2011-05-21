From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA and MediaController
Date: Sat, 21 May 2011 11:57:32 +0100
Message-ID: <20110521105732.GA10004@sirena.org.uk>
References: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
	<BANLkTikTO64=LWWvwSPM=3uAW_CHNbMDNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6589E244DF
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 12:57:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikTO64=LWWvwSPM=3uAW_CHNbMDNQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond, it's fairly basic process for Linux lists to do a reply to
all.  Please pay attention to this.

On Sat, May 21, 2011 at 10:43:55AM +0800, Raymond Yau wrote:
> 2011/5/18 pl bossart <bossart.nospam@gmail.com>:
> > During the ALSA/Embedded audio workshop two weeks ago we talked about
> > using the MediaController API (merged in 2.6.39) to provide userspace
> > with a graph-like representation of the transforms implemented in
> > firmware or hardware.

> How Media controller or PA handle hda jack retasking of those 3 jacks
> motherboard (channel mode or smart 5.1 switch) ?

> For those mini ITX motherboard without front audio panel, there will
> be no capture source if the HDA codec does not support stereo mix
> after the driver retask those input jacks for 5.1 outputs

This just sounds like a fairly basic reconfiguration of the CODEC, it's
no different to any other rerouting.

> Does this mean that those 3 jacks , 5 jacks and 6 jacks desktop need
> to add the rear panel jack to use snd_jack_report ?

It seems like a good idea to report any jacks we can do detection on....
