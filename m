From: David Balazic <david.balazic@hermes.si>
Subject: An alsa lib, that works over OSS drivers ?
Date: Mon, 19 Apr 2004 15:32:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC05EF@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi!

I have this idea that migh accelerate the adoption of ALSA.

It is a library ( dynamic ) that implements the ALSA API ( so to
applications it looks like
normal ALSA ), but accesses the hardware over OSS drivers. Like this :

app <--ALSA-API--> this_library <-- OSS-API--> OSS driver <---> sound
hardware

This means that application writers can write to ALSA API and be assured
that their
code will work on both ALSA and OSS systems.

The only thing needed is to install this new library on the OSS system ( the
ALSA systems
will off course work as they are ).

This new library would have the same name and API as the existing alsa
library.

How does this sound ? Feasible ?

Thanks for any reply,
David Balazic
----------------------------------------------------------------------------
-----------
David Balazic                      mailto:david.balazic@hermes.si
HERMES Softlab                 http://www.hermes-softlab.com
Zagrebska cesta 104            Phone: +386 2 450 8851 
SI-2000 Maribor
Slovenija
----------------------------------------------------------------------------
-----------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
----------------------------------------------------------------------------
-----------









-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
