From: Anders Torger <torger@ludd.luth.se>
Subject: How to detect sample rate change in runtime?
Date: Mon, 25 Mar 2002 18:55:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203251755.g2PHtG925535@d1o840.telia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I want to be able to detect when sample rate changes during runtime. 

An example scenario (by coincidence very similar to my application): a 
multi-channel convolution engine runs on an RME9652 which operates at 
44.1 kHz as clock slave. However, in runtime, the user switches cables 
to the card, which changes the sample rate to 48 kHz. Then the 
convolution engine gets a signal or something from ALSA that says "hey, 
the sample rate changed to 48 kHz, what are you going to do about it?", 
and then the convolution engine changes filters to those designed for 
48 kHz, or exits with an error if they don't exist.

So, what methods are there to solve this problem?

/Anders Torger
