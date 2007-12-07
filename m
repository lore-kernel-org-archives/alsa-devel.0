From: Andy Shevchenko <andy@smile.org.ua>
Subject: Re: [PATCH] Initial support of the Mitac 8252D
	(based	on ALC883)
Date: Fri, 7 Dec 2007 17:41:04 +0200
Message-ID: <20071207154104.GI24527@serv.smile.org.ua>
References: <20071206094612.GB24527@serv.smile.org.ua>
	<200712071323.26407.glvals@internet.is>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 27952103819
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 11:14:54 +0100 (CET)
Resent-Message-ID: <20071211101449.GA5439@serv.smile.org.ua>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <200712071323.26407.glvals@internet.is>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: G?sli <glvals@internet.is>
List-Id: alsa-devel@alsa-project.org

Hi G?sli!

 On Fri, Dec 07, 2007 at 01:23:26PM +0000, G?sli wrote next:

> > Not working while now:
> >  - Mic Jack sense
> >
> > Questionable:
> >  - is Mic have Jack sense?
> >  - one or two Mic volume controls?
> >  - CD/Line-in: presense in the mixer
> According to the manual that comes with windows, the external mic mutes the 
> internal one, but I don't have windows

Hm... Somebody of my colleguas explains me that windows blind as a beetle.
It asks user what the real device he attached. I'm thinking about callback
for ALSA to produce analogue way.

> Now kmix comes up with the headphone control, the mute works but the volume 
> slider not(not present in alsamixer).
> A great thing to have would be a master volume control.
Of course, you proposed logical way: the Front Volume may be called
as Master due to HP and speakers are used the same node (physical volume
control device). However, the all devices based on ALC883 don't have 'Headphone'
or 'Master' volume control in the code.

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
