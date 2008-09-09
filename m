From: "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>
Subject: RE: DaVinci ASoC DMA stalls
Date: Tue, 9 Sep 2008 06:52:31 -0500
Message-ID: <F8C55F6A02E92D48BDDFC6048552C6F1142BB196@dlee03.ent.ti.com>
References: <48BFE50E.3000802@acdstar.com> <48C015B2.2070401@gmail.com>
	<48C05FFD.4030009@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <48C05FFD.4030009-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Lokowich <lokowich-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
Cc: ALSA-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> My test is simply to run aplay or speaker-test,
> then quit and run it again.  The first run is audible, the second and
> subsequent runs are not audible until I provide a manual DMA event trigge=
r.

When the ASP transmitter is taken out of reset it sends XEVT to the EDMA wh=
ere it is "captured" in event register (ER).  If that event gets cleared ou=
t before turning on the EDMA you'll end up with a scenario like you describ=
ed, i.e. once you kick off a transfer manually it will then run.  I haven't=
 looked at the code you're using, but it sounds to me like the (re-)initial=
ization sequence isn't correct.

The best way for the code to work would be for the EDMA to be configured BE=
FORE the McBSP.  That way, even if the EDMA initialization procedure clears=
 the ER bits it won't matter because when the McBSP is subsequently release=
d from reset it will send a new XEVT to the EDMA.

Brad
