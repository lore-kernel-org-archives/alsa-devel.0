From: Paul Davis <pbd@op.net>
Subject: Re: DTMF recognition
Date: Thu, 25 Jul 2002 10:45:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17Xjod-0005Qf-00@usw-sf-list1.sourceforge.net>
References: <200207251412.59730.do1ypv@linux>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 25 Jul 2002 14:12:59 +0200."
             <200207251412.59730.do1ypv@linux>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Philipp Vollmer <vollmer.philipp@t-online.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hello to all,
>
>who has already done DTMF recognition with ALSA ( OSS )?
>I searched for examples in google, but I have found that
>only in TODO lists ;-(.
>
>Is this so difficult or why doesn't exist anything about that?

its a relatively trivial FFT problem. use FFTW to analyse the signal,
then look for two predominant frequencies, and check their values
against a table.

believe it or not, there are many, many things that have never been
written in the open source arena.

--p



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
