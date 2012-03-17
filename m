From: Adam Williamson <awilliam@redhat.com>
Subject: Re: Internal speaker output from Sony Vaio Z (2010
 model) lost somewhere between 3.1.0 and 3.2.6
Date: Fri, 16 Mar 2012 22:15:16 -0700
Message-ID: <1331961316.1841.8.camel@adam>
References: <1331939409.22414.29.camel@adam>
	<CAN8ccibZfNEd05FDwcb2XENaW7VFkkun2GFJ2xxGmLyKgzdw-g@mail.gmail.com>
	<1331950527.1841.1.camel@adam>
	<CAN8cciZCV9f_MLLygK-SAmatCBGMAXwzUTKxRdxNLXZcMZXtpA@mail.gmail.com>
	<1331959510.1841.6.camel@adam>
	<CAN8cciaJ1H8B7y0SXxhuKwB8bByr5kosZadYDcogFRyFrfp18Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id C0F1A10B93B
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 06:15:18 +0100 (CET)
In-Reply-To: <CAN8cciaJ1H8B7y0SXxhuKwB8bByr5kosZadYDcogFRyFrfp18Q@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2012-03-17 at 13:11 +0800, Raymond Yau wrote:
> 2012/3/17, Adam Williamson <awilliam@redhat.com>:
> > On Sat, 2012-03-17 at 11:10 +0800, Raymond Yau wrote:
> >> 2012/3/17, Adam Williamson <awilliam@redhat.com>:
> >> > On Sat, 2012-03-17 at 10:04 +0800, Raymond Yau wrote:
> >>
> >> >
> >> >> Does the laptop surround51 by retasking two mic jacks and headphone ?
> >> >
> >> > I don't _think_ so. AFAICS it only has two jacks - one
> >> > headphone/speaker, one mic. There's no third jack anywhere that I can
> >> > see.
> >> > --
> >>
> >> you may need to use hda-analyzer to find out which ext mic is correct ?
> >
> > I don't really care about the microphone socket. I just want the
> > speakers to work. Or is it important for me to figure that out?
> >
> 
> The auto parser also provide auto mic detection,  external mic is used
> automatically selected.when you have one ext mic and one int mic.
> 
> you need a pin fixup or early patch to remove this redundant jack
> 
> Since the two mic jacks are capable of retasking as output jacks
> 
> This change the logic of auto mic detection.for those laptop with
> three/four audio jacks which support surround51/surround71

oh, okay. so you need me to figure out which is the actual, physical mic
jack so the other one can be masked. I suppose the third one might
actually exist on a docking station, or something?
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
