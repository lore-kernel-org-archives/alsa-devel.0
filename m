From: Markus Grabner <grabner@icg.tu-graz.ac.at>
Subject: sample rate conversion
Date: Thu, 2 Sep 2004 19:53:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409021953.57939.grabner@icg.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


	Hi!

    I am working on a Linux driver for a weird device that only accepts 24bit 
input at 39062.5Hz (PODxt Pro by Line6), so for this driver to be able to 
play regular audio files, the built-in sample rate conversion (via plughw:n) 
has to be used. I noticed that the resampler improved a lot since ALSA-1.0.4, 
but it still has some problems. The sound quality is significantly reduced 
compared to a file that is resampled offline (e.g., by the resampler included 
in "sox"). It sounds like additional noise when high frequencies occur 
(aliasing?). It should be technically possible to use the "sox" algorithm in 
the ALSA libraries, but before I dive into the code, I wanted to ask if 
anybody else is aware of this problem or maybe even works on a solution!

	Kind regards,
		Markus


-- 
Markus Grabner - Computer Graphics and Vision
Graz University of Technology, Inffeldgasse 16/II, 8010 Graz, Austria
Phone: +43/316/873-5041, Fax: +43/316/873-5050
Email: grabner@icg.tu-graz.ac.at, WWW: http://www.icg.tu-graz.ac.at/~grabner


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
