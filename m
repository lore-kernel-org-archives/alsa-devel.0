From: Immanuel Litzroth <immanuell@enfocus.be>
Subject: Re: envy24control crash
Date: Fri, 30 Sep 2005 12:44:59 +0100
Message-ID: <1x36wzic.fsf@immanuelinux.site>
References: <MEGASERVERBhcJ5ptwf00002500@office.enfocus.be>
	<433C442B.1080700@cubic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <433C442B.1080700@cubic.org> (Dirk Jagdmann's message of "Thu,
 29 Sep 2005 21:44:43 +0200")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Jagdmann <doj@cubic.org>
Cc: Immanuel Litzroth <immanuell@enfocus.be>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Dirk Jagdmann" <doj@cubic.org> writes:

> Hello Immanuel,
>
>> Has any fixed the crashing envy24control when the midichannel is not given
>> as command line argument?
>> I have a 3 line fix which I could submit.
>
> I think this was already fixed in the CVS version. Please test the CVS
> version. If it is still crashing, we would like to see your patch.
>
Yes, it seems to have been fixed by checking if(!seq) ..
Will this be in 1.0.10 release? it is not in 1.0.10.rc1.

Thanks.
Immanuel



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
