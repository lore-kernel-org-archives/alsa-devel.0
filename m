From: Clive Messer <clive@vacuumtube.org.uk>
Subject: Re: Timer instability
Date: Wed, 25 Feb 2009 16:24:18 +0000
Message-ID: <200902251624.18472.clive@vacuumtube.org.uk>
References: <20090219024611.GA7930@tango.0pointer.de>
	<200902251511.44049.clive@vacuumtube.org.uk>
	<s5hbpsqo6pm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yCXpJUbjjsI2mhi"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from abbey4.objectsoft-systems.ltd.uk
	(abbey4.objectsoft-systems.ltd.uk [87.194.123.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 56BC824338
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 17:24:19 +0100 (CET)
In-Reply-To: <s5hbpsqo6pm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_yCXpJUbjjsI2mhi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 25 Feb 2009 15:51:33 you wrote:
> At Wed, 25 Feb 2009 15:11:44 +0000,
>
> Clive Messer wrote:
> > 36192	36191	100068	3	0	0	1	2
> > 36195	36194	100090	2	0	0	1	2
> > 36198	36198	100113	1	0	0	1	2
> > 36207	36206	63854	2816	1600	0	1	3
> > 36212	36211	63854	2815	1601	4	1	3
> > 36216	36216	63854	2814	1602	4	1	3
> > 36221	36220	63854	2813	1603	4	1	3
> > 36225	36225	101224	4460	-44	4	1	3
>
> This is pretty weird.  Is this behavior always reproducible?

Nope. I get different results every time I run it.

> What shows with the patch below to alsa-lib?

Here's one (attached) I just did with the new patch that shows the crazy high 
numbers again.

> Also, any change if you play with position_fix parameter, such as,
> position_fix=1?

I'll try that module option next.

Regards

Clive
-- 
Clive Messer <clive@vacuumtube.org.uk>


--Boundary-00=_yCXpJUbjjsI2mhi
Content-Type: text/x-log;
  charset="UTF-8";
  name="run2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="run2.log"

hwsync: 0(0), 0(0)
29049	29047	0	4416	0	4	1	2
hwsync: 0(0), 1(0)
29058	29058	22	4415	0	4	1	2
hwsync: 0(0), 2(0)
29061	29061	45	4414	0	4	1	2
hwsync: 0(0), 3(0)
29065	29064	68	4413	0	4	1	2
hwsync: 0(0), 4(0)
29068	29067	90	4412	0	4	1	2
hwsync: 0(0), 5(0)
29070	29070	113	4411	0	4	1	2
hwsync: 0(0), 6(0)
29074	29073	136	4410	0	4	1	2
hwsync: 0(0), 7(0)
29076	29076	158	4409	0	4	1	2
hwsync: 0(0), 8(0)
29079	29079	181	4408	0	4	1	2
hwsync: 0(0), 9(0)
29082	29082	204	4407	0	4	1	2
hwsync: 0(0), 10(0)
29085	29085	226	4406	0	4	1	2
hwsync: 0(0), 11(0)
29088	29088	249	4405	0	4	1	2
hwsync: 0(0), 12(0)
29091	29091	272	4404	0	4	1	2
hwsync: 0(0), 13(0)
29094	29094	294	4403	0	4	1	2
hwsync: 0(0), 14(0)
29099	29099	317	4402	0	4	1	2
hwsync: 0(0), 15(0)
29101	29101	340	4401	0	4	1	2
hwsync: 0(0), 16(0)
29103	29103	362	4400	0	4	1	2
hwsync: 0(0), 17(0)
29105	29105	385	4399	0	4	1	2
hwsync: 0(0), 18(0)
29107	29107	408	4398	0	4	1	2
hwsync: 0(0), 19(0)
29109	29109	430	4397	0	4	1	2
hwsync: 0(0), 20(0)
29111	29111	453	4396	0	4	1	2
hwsync: 0(0), 21(0)
29113	29113	476	4395	0	4	1	2
hwsync: 0(0), 22(0)
29115	29115	498	4394	0	4	1	2
hwsync: 0(0), 23(0)
29117	29117	521	4393	0	4	1	2
hwsync: 0(0), 24(0)
29159	29119	544	4392	0	4	1	2
hwsync: 2080(0), 6496(0)
70717	70716	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70719	70718	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70720	70720	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70722	70722	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70724	70724	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70726	70725	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70727	70727	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70729	70729	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70731	70731	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70733	70733	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70735	70735	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70737	70736	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70738	70738	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70740	70740	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70742	70742	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70744	70743	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70745	70745	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70747	70747	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70749	70749	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70751	70751	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70753	70752	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70754	70754	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70756	70756	47142	0	4416	0	0	3
hwsync: 2080(0), 6496(0)
70758	70758	47142	0	4416	0	0	3
hwsync: 1472(0), 6496(0)
70763	70762	104573379136040	4971973988617026976	-4971973988617022560	4	1	3

--Boundary-00=_yCXpJUbjjsI2mhi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_yCXpJUbjjsI2mhi--
