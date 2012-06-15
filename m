From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: McBSP in TDM for audio codec
Date: Fri, 15 Jun 2012 09:34:48 +0300
Message-ID: <4FDAD788.9060407@ti.com>
References: <CADU0PKEAQtEP_26YwyiKXg0tVO=aAH9fDUuk7cohNG51nUHRFA@mail.gmail.com>
	<4FCE0127.8080404@ti.com>
	<CADU0PKGmx=dqdUVxvTUDKr2qG_3+3yXcWeKTb__50ayjPHgV+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 8028E2454E
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 08:34:36 +0200 (CEST)
Received: by lbbgh12 with SMTP id gh12so2288422lbb.25
	for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2012 23:34:33 -0700 (PDT)
In-Reply-To: <CADU0PKGmx=dqdUVxvTUDKr2qG_3+3yXcWeKTb__50ayjPHgV+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: learnom learnom <learnom1@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 06/06/2012 04:56 AM, learnom learnom wrote:

> I want to control these channel0, 1, 2, 3 independently.
> For example, lets say,
> 1) If I want to transmit the data in channel 1 only, i want to see the
> channel0 null, channel1 with data, channel 2 null, channel 3 null.
>  =

> 2)I want to transmit data at the same time, channel 1 (data) , channel2
> (Data), channel3 data, channel(data).
>  =

> Can you please let me know how to recognize that the user is sending from
> which channel, and how to setup for these two scenarios.


User space need to make sure that it is placing the data to the correct
channel. The McBSP/sDMA just see a stream of data in a memory.
McBSP do have TDM mode where you can have limited control over how the
channels are handled, but it still handle the data as stream and you can on=
ly
tell which slot it should use and which one to ignore. This TDM programming
mode is not implemented since we did not needed it so far and without a cod=
ec
it is kind of hard to test it (well, with a scope the channels can bee
observed but that would be all).

-- =

P=E9ter
