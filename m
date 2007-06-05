From: "Juan Manuel Lopez Baio" <jmbaio@gmail.com>
Subject: Problem restarting alsa: can't set buffer size
Date: Tue, 5 Jun 2007 16:11:02 -0300
Message-ID: <ef9bc5590706051211x6721440esab78f04e1f987913@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C5092443C
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2007 21:11:04 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 67so1121578wri
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2007 12:11:03 -0700 (PDT)
Content-Disposition: inline
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

Hello. I'm developing an application that records input from ALSA and
process it. To do so I user the API starting with snd_pcm_open and follow
with the parameters settings and so on, and once the app is done and exits,
it closes with snd_pcm_hw_params_free and snd_pcm_close.
The problem is that afterwards, if I restart the application, I can't set up
ALSA, becausea continuous calls to snd_pcm_hw_params_set_buffer_size always
fail  (I start with a buffer size of 8192 and keep dividing it by 2). I
finally have to restart the system in order to get it to work again.
I'm on a Mandriva box with gcc 4.1.2
=BFAny thoughts on this? Thanks in advance!

juan
