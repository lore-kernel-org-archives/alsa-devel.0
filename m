From: Justin Cormack <justin@street-vision.com>
Subject: Re: hdsp/new 9652
Date: 03 Dec 2002 19:36:24 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038944189.6697.7.camel@lotte>
References: <200212031900.gB3J0I705143@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200212031900.gB3J0I705143@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2002-12-03 at 19:00, Paul Davis wrote:
> can the person who fixed their hdsp driver to work with the new 9652
> please post a patch (c/o diff -u) here? i would like to get the fix
> into CVS ...
> 

there wasnt much, assuming that Takashi's patch is in cvs, which I think
it is.

Any news on mixer support? There seem to be Windows and Mac drivers with
mixer suuport now.

It was only:

--- hdsp.c-orig 2002-12-03 19:28:40.000000000 +0000
+++ hdsp.c      2002-12-03 19:28:06.000000000 +0000
@@ -2966,6 +2966,7 @@

        switch (rev & 0xff) {
        case 0xa:
+       case 0x64:
                /* hdsp_initialize_firmware() will reset this */
                hdsp->card_name = "RME Hammerfall DSP";
                break;




-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
