From: javi perez <havingfunwithjavi@gmail.com>
Subject: newbie, arecord
Date: Mon, 28 Jun 2010 18:38:37 +0200
Message-ID: <AANLkTiko21FyDgoTz2lPx-DtVsT48sXXCFzUkJ4RackM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EF262454D
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 18:38:39 +0200 (CEST)
Received: by gyd10 with SMTP id 10so6223752gyd.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 09:38:38 -0700 (PDT)
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

I am trying to do a speech recognition system. In the aplay file I would
like to conver the unsigned char buffer
to a float buffer to be able to make comparisons the way I would like. The
floats that I am getting after the conversion are these.
How should I do the conversion from unsigned char to float array? thanks in
advance.

819 -464604244644772930012428885483847680.000000
820 -542490915911345743841838949652758528.000000
821 -495758857691688295559156595670646784.000000
822 -480181610589352498484045935735209984.000000
823 -441239146465853748477054432634208256.000000
824 -376333296573780517983308202832297984.000000
825 -503547144523165508473277153076576256.000000
826 -485374263974618640302095603012206592.000000
827 -495758501164956981369637424722870272.000000
828 -433450265423157678580401923648651264.000000
829 -415277147190123267616207592952430592.000000
830 -425662216276168008459294146874572800.000000
831 -477585818686816398859299858518376448.000000
832 -394508395510877785555942372127277056.000000
833 -472393086073387742776912597697429504.000000
834 -482778551300245054941687119339323392.000000
835 -584029726534518193323939684778246144.000000
836 -511336897075649235277643191045586944.000000
837 -558067806486950226727430438640418816.000000
838 -513933085118997906224077235982172160.000000
839 -302397753578834695235772573852631040.000000


      float* float_array;

        while (rest > 0 && recycle_capture_file == 0) {
            size_t c = (rest <= (off64_t)chunk_bytes) ?
                (size_t)rest : chunk_bytes;
            size_t f = c * 8 / bits_per_frame;

            if (pcm_read(audiobuf, f) != f)
                break;

            float_array=(float*)malloc(f);
            memcpy(float_array,audiobuf,f);
            int z=0;

            for(z=0; z<f/sizeof(float);z++){
                printf("%d %f\n",z,float_array[z]);
            }


            /*if (write(fd, audiobuf, c) != c) {
                perror(name);
                prg_exit(EXIT_FAILURE);
            }*/
            count -= c;
            rest -= c;
            fdcount += c;
        }
