From: Kevin Conder <kconder@interaccess.com>
Subject: Helping with documentation.
Date: Mon, 11 Mar 2002 12:03:37 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.3.96.1020311111503.27495A-100000@yin.interaccess.com>
Reply-To: kevin@kevindumpscore.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-reply-to: <Pine.LNX.4.33.0203090915040.520-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 9 Mar 2002, Jaroslav Kysela wrote:

> I don't know, if you are noticed, that some documentation already exist at
> http://www.alsa-project.org/alsa-doc/alsa-lib .

	Could you generate a tar-ball of the HTML pages for off-line use?
A PDF would also be nice. 

> The problem is, that I'm not English native writer and
> always busy with other maintaince things, so definitely, I can't create
> perfect English documentation.
> It would be
> really helpful from developers to give some feedback and/or rephase my
> texts.

	I ran all of the pages through a spell checker. I noticed spelling
mistakes already in a few places...

* The word "constants" is misspelled in various ways.
* The word "highlevel" should be two words: "high level".
* The word "identificator" should probably be "identifier".
* Sometimes the word "obtain" is misspelled as "obatin".
* Sometimes the word "occurred" is misspelled as "occured".
* Sometimes the word "portamento" is misspelled as "pornamento" or 
"portnamento".
* Sometimes the word "sustenuto" is misspelled as "sostenuto".


	Please note that "pornamento" and "portnamento" occur in constants
(in asoundef.h, IIRC). Correcting them could possibly have an adverse
effect on existing code. What should we do?

	I don't know how to send in this feedback. Unless someone tells me
otherwise, I'll create patches and post them here. My next phase is to
check for grammar mistakes.


-- Kevin Conder, kevin@kevindumpscore.com



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
