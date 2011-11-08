From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Mixer-related LED triggers
Date: Mon, 7 Nov 2011 22:29:31 -0200
Message-ID: <20111108002931.GD6929@khazad-dum.debian.net>
References: <1320704770.31112.53.camel@Thinkpad-420s>
	<20111107235729.GC6929@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111107235729.GC6929-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jerone Young <jyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

(please CC me in any replies).

There is some interest into adding Linux support to control the MIC
muted LED in thinkpads, as it appears that Lenovo did not go the safer
(and OS-agnostic) way and did not slave the MIC to an EC-controlled
analog switch as they do for the speakers.

Still, I do not like the idea of doing this LED control through
userspace.  I'd prefer to do that just as a last resort: if some
hardware has the UI to notify the user when a MIC is active, we should
strive to make that UI something the user can trust not to be so easily
subverted.

Therefore, I'd greatly prefer if we could keep this stuff in-kernel
somehow.

Would it be possible for ALSA to provide a set of standard LED triggers
related to the common mixer controls, that we could hook to in platform
devices?  That would be a nice, generic solution that could be used by
anyone who wants to provide interesting LEDs tied to ALSA mixer
controls...

I'd probably need to get a new feature added to the LED class to support
hidden LEDs (ones that are not exposed to userspace) or to come up with
a clean way for platform devices to hook to standard LED triggers
without going through the LED class, but that's not an ALSA problem...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
