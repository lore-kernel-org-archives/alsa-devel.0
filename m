From: Mario Loritz <loritz@fh-furtwangen.de>
Subject: config bug with sbawe and --with-isapnp=no
Date: Thu, 22 Jan 2004 12:49:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401221249.07577.loritz@fh-furtwangen.de>
Reply-To: loritz@fh-furtwangen.de
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

Hello List,

Since about Alsa version 0.9.8, the compilation of the alsa-driver for
the Sound Blaster AWE (non-pnp) results in a non-usable driver.

The driver fails to load with a message about a symbol error.
(Sorry, lost the output, have to regenerate it.)

If I compile the driver with pnp turned on, then I can load the 
driver with the option "isapnp=no", which didn't work BEFORE alsa 0.9.8.

So we replaced one bug with another, didn't we?

Thanks for reading,
Mario



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
