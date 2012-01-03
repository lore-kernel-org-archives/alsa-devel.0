From: Daniel Mack <zonque@gmail.com>
Subject: Re: question application playback
Date: Tue, 03 Jan 2012 13:28:55 +0100
Message-ID: <4F02F487.9080906@gmail.com>
References: <1325593416.22411.YahooMailNeo@web161301.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2892E24793
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 13:29:00 +0100 (CET)
Received: by eekb57 with SMTP id b57so15015908eek.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Jan 2012 04:28:59 -0800 (PST)
In-Reply-To: <1325593416.22411.YahooMailNeo@web161301.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/03/2012 01:23 PM, Ricardo Barbosa wrote:
> I am new to development using the alsa API and follow the link code http://equalarea.com/paul/alsa-audio.html
> 
> insert the following code.
> 
>  FILE *fp;
>  fp = fopen("file.mp3", "r");

MP3s are compressed audio files that cannot be used directly with the
ALSA API. If you have to use mp3 files, have a look at libmpg123 or use
a higher level interface in the first place, for example GStreamer.


Daniel
