From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: [ANN] hdspmixer-1.1
Date: Mon, 28 Jul 2003 20:33:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030728183344.GA2787@finnendahl.de>
References: <1150.62.39.221.4.1059308878.squirrel@www.undata.org> <1358.62.39.222.123.1059320697.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1358.62.39.222.123.1059320697.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi Thomas,

 congrats! Great to have this with linux as well (and it's good to have
it look the same, too). It compiled right away after a minor fix for
FLTK header file name (patch attached).

--
Orm


Am Sonntag, den 27. Juli 2003 um 17:44:57 Uhr (+0200) schrieb Thomas
Charbonnel:
>
> Hi,
> 
> This is already a bugfix release :
> 
>     * Fixes a typo for Digiface and H9652 cards in HDSPMixerSelector.cxx
>       (caused a crash on startup)
>     * Fixes a menu messing bug in Submix handling
>     * Fixes FLTK detection in configure
>     * Fixes a bug preventing full reset to factory settings
> 
> It's available from:
> http://www.undata.org/~thomas/
> 
> Thomas
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="hdspmixer.patch"

--- src/HDSPMixerMeter.h-orig	2003-03-04 10:06:46.000000000 +0100
+++ src/HDSPMixerMeter.h	2003-07-28 20:20:39.000000000 +0200
@@ -23,7 +23,7 @@
 #define HDSPMixerMeter_H
 
 #include <FL/Fl_Widget.H>
-#include <FL/fl_draw.h>
+#include <FL/fl_draw.H>
 #include "HDSPMixerWindow.h"
 #include "HDSPMixerPeak.h"
 #include "pixmaps.h"

--zhXaljGHf11kAtnf--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
