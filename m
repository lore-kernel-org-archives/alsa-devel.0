From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP matrix mixer
Date: 30 Nov 2002 18:33:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038677584.8314.38.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I started implementing a GUI for the HDSP matrix mixer using the fltk
toolkit. I want to get as close as possible to the TotalMix RME
application, thus I'm trying to implement hardware metering using the
Peak and RMS HDSP registers. The peak value covers the whole int range,
and seems quite usable to me (though it would need some king of
logarithmic scaling), but the rms value, despite being an integer64,
only covers a very narrow range. What is the correct way to handle those
values ?

Regards,
Thomas




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
