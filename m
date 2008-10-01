From: javier.martinc@alumnos.unican.es
Subject: How to start with a driver for custom hardware?
Date: Wed,  1 Oct 2008 17:43:36 +0200
Message-ID: <20081001174336.b3mj2efijo8kcgwg@correo.alumnos.unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ccserver2.unican.es (ccserver2.unican.es [130.206.5.101])
	by alsa0.perex.cz (Postfix) with ESMTP id BF5AB243CF
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Oct 2008 17:43:53 +0200 (CEST)
Received: from ccserver2.unican.es (ccserver2.unican.es [127.0.0.1])
	by ccserver2.unican.es (Postfix) with ESMTP id EB6A315D97D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Oct 2008 17:43:27 +0200 (CEST)
Received: from ccserver25.unican.es (ccserver25.unican.es [130.206.5.220])by
	ccserver2.unican.es (Postfix) with ESMTP id E0082E4B58for
	<alsa-devel@alsa-project.org>; Wed,  1 Oct 2008 17:43:27 +0200 (CEST)
Received: from correo.alumnos.unican.es (localhost.localdomain
	[127.0.0.1])by ccserver25.unican.es (Postfix) with ESMTP id
	A6A0CB00BCfor
	<alsa-devel@alsa-project.org>; Wed,  1 Oct 2008 17:43:36 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])by
	correo.alumnos.unican.es (Postfix) with ESMTP id 97CB1B00B4for
	<alsa-devel@alsa-project.org>; Wed,  1 Oct 2008 17:43:36 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I am trying to develop an ALSA compatible driver for a custom hardware.

The situation is the following:
We are using a Cyclone II FPGA with a nommu NiosII processor and uClinux.
We have an external TLV320AIC110 codec with I2C control interface and PCM a=
udio
interface.
Into the FPGA we have a hardware module which controls both interfaces and
basically copies x amount of data into a given memory position and vice ver=
sa.

I have been looking at the documentation (which in my honest opinion is sca=
rce)
and  many doubts have arisen.

For example, should I used alsa or asoc? In my opinion, alsa documentation =
is
more clear than asoc, but it is highlt oriented to pci drivers.

As you can see it is a simple hardware which control registers are mapped i=
nto
memory. Which part of the alsa driver takes care of accesing these hardware
dependent registers?

Maybe we should use some other standard hardware module into the FPGA to get
better alsa compliance?

I know these are very generic and begginer questions but, anyway, any help =
will
be welcome.

Thank you.

Javier Mart=EDn
