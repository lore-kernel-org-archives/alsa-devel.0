From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Wed, 21 Jan 2004 14:20:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401211920.i0LJK5Jl001091@dhin.linuxaudiosystems.com>
References: <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 21 Jan 2004 18:41:00 GMT."
             <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <Ed@Wildgooses.com>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have a few usability comments with regards to the drivers that I would
>like to share, will draft a fuller email later, but basically I am using it
>as a hifi input for music, nothing else, but I'm frequently getting very
>jittery & broken up audio (guessing that the default alsa buffer/latency
>size is really tiny?) and not many input formats are supported which means
>that the plug driver is usually required (not a huge problem though).  It

its the philosophy of ALSA that the "hw:N" drivers export the h/w
functionality, which in this case indeed means "not many input formats
are supported" (i.e. the h/w doesn't do this). this is precisely what
the "plughw:N" devices are for.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
