From: "Mirabella, Mathew J" <Mathew.Mirabella@team.telstra.com>
Subject: Audigy 2 support.
Date: Thu, 20 Mar 2003 16:53:25 +1000
Sender: sound-list-admin@redhat.com
Message-ID: <73388857A695D31197EF00508B08F2980A00EE6B@ntmsg0131.corpmail.telstra.com.au>
Reply-To: sound-list@redhat.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <sound-list-admin@redhat.com>
content-class: urn:content-classes:message
Errors-To: sound-list-admin@redhat.com
List-Help: <mailto:sound-list-request@redhat.com?subject=help>
List-Post: <mailto:sound-list@redhat.com>
List-Subscribe: <https://listman.redhat.com/mailman/listinfo/sound-list>,
	<mailto:sound-list-request@redhat.com?subject=subscribe>
List-Unsubscribe: <https://listman.redhat.com/mailman/listinfo/sound-list>,
	<mailto:sound-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://listman.redhat.com/mailman/private/sound-list/>
To: alsa-devel list <alsa-devel@lists.sourceforge.net>, alsa-user list <alsa-user@lists.sourceforge.net>, sound-list list <sound-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

All.

Could someone please let me know the status of Audigy 2 support with the alsa drivers?

Audigy 2 is not yet shown in the supported sound cards matrix.

However, I am aware that the latest emu10k1 source from cvs (this year, 2003) now has Audigy 2 support, whereas the latest compiled version does not (from late last year, 2002).

I would like to know what version of the emu10k1 source is used in the latest release of the alsa drivers, and also what version is used in the latest alsa stuff from cvs.

Support for modern creative cards requires the emu10k1 stuff (as mentioned on the sound cards matrix pages for alsa.  So essentially I want to know if alsa has availed itself of the newest cvs emu10k1 drivers, or if alsa developers are working on audigy 2 support themselves.

Further, could someone please tell me the modulename for the cvs version of alsa?
I have the following:
  cvs -d:pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa login
  cvs -z3 -d:pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa co MODULENAME
but when i try putting alsa or alsa-project in for MODULENAME, i get an error that suggest there is no such module etc.

btw:  the cvs instructions on the cvs page for alsa did not work either, so you will notice i have altered the commands shown above somewhat so at least i can log in.

Mat.
