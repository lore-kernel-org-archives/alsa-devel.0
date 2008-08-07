From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: S24_LE Mode for USB Driver
Date: Thu, 07 Aug 2008 16:25:50 -0400
Message-ID: <489B5A4E.3040903@ieee.org>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp121.rog.mail.re2.yahoo.com (smtp121.rog.mail.re2.yahoo.com
	[206.190.53.26]) by alsa0.perex.cz (Postfix) with SMTP id 201C7249A0
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 22:25:52 +0200 (CEST)
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

Hi All,

It looks like the parse_audio_format_i_type function at line 2369 of usbaudio.c 
(linux v2.6.23) doesn't support the case where  bSubframeSize (fmt[5]) = 4 bytes 
and  bBitResolution (fmt[6]) = 24 bits, which should correspond to a S24_LE (or 
BE) type. I'm developing a new USD DAC which supports this mode (24-bit sample 
in a 4 byte package). Right now Linux sends me S32_LE formated data, which is 
wrong. Would it be possible to expand this function to support S24_LE/BE? It 
would only require adding a few lines of code.

Thanks!
Charles
