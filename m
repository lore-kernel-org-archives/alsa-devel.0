From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: Alsa buffer
Date: Tue, 14 Jul 2009 08:55:58 +0700
Message-ID: <c697747b0907131855m64537b16ra2d1e24189a0381f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f192.google.com (mail-px0-f192.google.com
	[209.85.216.192])
	by alsa0.perex.cz (Postfix) with ESMTP id EF931245E5
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 03:55:59 +0200 (CEST)
Received: by pxi30 with SMTP id 30so1885001pxi.16
	for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2009 18:55:58 -0700 (PDT)
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

Hi,

I'm trying to get meaningful voice from ALSA buffer. I read tutorial on
http://www.suse.de/~mana/alsa090_howto.html<http://www.suse.de/%7Emana/alsa090_howto.html>and
realize that if alsa use 16 bit format value then I have to byte shift
to store it in 8 bit unsigned char buffer. I see this in sine wave generator
in tutorial. To confirm it, I try to save the output into file and open it
in Matlab. I want to know if this is correct, because when I try saving alsa
buffer on a from recording I still get noise not the voice.

Thank you.

Best regards,

Arif


This is my implementation :

int main()
{
    int nchannel = 1;
    int periodsize = 8192;
    int frame_size = nchannel * (16 / 8);
    int num_frames = periodsize / frame_size;

    unsigned char *data;
    int l2;
    short s;

    data = (unsigned char *)malloc(periodsize);

    // fill the buffer
    for(l2 = 0; l2 < num_frames; l2++)
    {
        s1 = (l2 % 128) * 100 - 5000;
        data[2*l2] = (unsigned char)s1;
        data[2*l2+1] = s1 >> 8;
    }

    // directly save
    FILE *fp1 = fopen("sineout1", "w");

    for (int i = 0; i < periodsize; i++)
    {
        fprintf_s(fp1, "%d\n", data[i]);
    }

    fclose(fp1);

    // with bit shifting from char to short
    FILE *fp2 = fopen("sineout2", "w");

    for (int i = 0; i < num_frames; i++)
    {
        short newval = data[2*i+1] << 8;
        newval += data[2*i];

        fprintf_s(fp2, "%d\n", newval);
    }

    fclose(fp2);

    return 0;
}
