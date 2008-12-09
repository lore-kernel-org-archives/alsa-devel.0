From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: How to write a PXA CPU
Date: Tue, 9 Dec 2008 14:03:45 +0000
Message-ID: <20081209140342.GG1630@sirena.org.uk>
References: <fd90355f0812081916u34058f77pa0ead68a1ab93aae@mail.gmail.com>
	<fd90355f0812090559h1b17826cm526da68b08fbf064@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8324B2446C
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:17:36 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.63)
	(envelope-from <broonie@sirena.org.uk>) id 1LA3Bh-0003ax-G2
	for alsa-devel@alsa-project.org; Tue, 09 Dec 2008 14:03:45 +0000
Content-Disposition: inline
In-Reply-To: <fd90355f0812090559h1b17826cm526da68b08fbf064@mail.gmail.com>
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

On Tue, Dec 09, 2008 at 02:59:39PM +0100, Juan Pablo G?mez  wrote:
> Excume for my english, I want to say pxa file.

> We need to write a nex pxa file based in the corgi and poodle drivers for
> pxa.
> It's a requeriment  needed for our board to use the alsa driver (altera de2
> codec wm8731)

There's documentation in:

	Documentation/sound/alsa/soc/machine.txt

and examples in the other machine drivers.  Something like the em-x270
is pretty minimal.
