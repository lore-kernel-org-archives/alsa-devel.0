From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Help needed with sequencer driver for Mikmod
Date: Tue, 23 Apr 2002 22:19:32 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020423221932.A13968@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Nobody answered my previous mail so maybe a better subject will help...

I have written a ALSA sequencer driver for Mikmod. The problem is that I
can't get any sound from it. It uses simple instruments so it should work
with GUS and Trident 4dwave cards. I had a semi working driver before the
sequencer API changes but I misplaced it. This current driver is based on
alsamod and the drv_ultra driver from Mikmod. I'd appreciate if someone
who knows the sequencer could take look at the code. I have a patch
against libmikmod-3.1.9 at "http://www.saunalahti.fi/~syrjala/alsa/"

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
